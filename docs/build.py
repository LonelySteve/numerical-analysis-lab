#!/usr/bin/env python3
"""
tex 文档构建脚本
--------------
处理 tex 模板文件，并输出渲染结果至指定目录

"""

import os
import re
from pathlib import Path
from typing import Set

import jinja2
from easy_config import EasyConfig


class BuildConfig(EasyConfig):
    FILES = ["buildConfig.ini"]
    NAME = "Build"

    # 作者相关的信息
    author_name: str
    author_class_name: str
    author_major_name: str
    author_student_number: str
    # 源码目录，模板内可通过向 include_code 函数传递相对于该目录的路径来包含指定源代码的内容
    source_code_dir_path: str = "src/"
    # 模板搜索目录
    template_search_path: str = "docs/"
    # 根模板主文件名（不带扩展名）后缀
    root_template_file_suffix: str = "Root"
    # 构建输出目录
    output_dir_path: str = "build/"


# http://eosrei.net/articles/2015/11/latex-templates-python-and-jinja2-generate-pdfs

docs_path = os.path.dirname(os.path.abspath(__file__))

latex_jinja_env = jinja2.Environment(
    block_start_string="\\pyblock{",
    block_end_string="}",
    variable_start_string="\\pyvar{",
    variable_end_string="}",
    comment_start_string="\\#{",
    comment_end_string="}",
    line_statement_prefix="%%",
    line_comment_prefix="%#",
    trim_blocks=True,
    autoescape=False,
    loader=jinja2.FileSystemLoader(docs_path),
)


def main(config: BuildConfig):

    # 过滤器
    def real_relative_path(path: str):
        return Path(
            os.path.join(
                "../"
                * len(
                    Path(config.template_search_path)
                    .absolute()
                    .relative_to(Path().absolute())
                    .parents
                ),
                config.template_search_path,
                path,
            )
        ).as_posix()

    def include_code(path: str):
        source_path = Path(config.source_code_dir_path) / path
        with open(source_path, "r", encoding="utf-8") as fp:
            return fp.read()

    children: Set[Path] = set()

    def input_tex(path: str):
        child_tex_path = Path(config.template_search_path) / path
        if child_tex_path in children:
            return path

        # 处理子模板
        relative_path = str(
            child_tex_path.relative_to(config.template_search_path).as_posix()
        )
        template = latex_jinja_env.get_template(relative_path)
        child_tex_file_output_path = Path(config.output_dir_path) / relative_path
        # 自动建立可能缺失的文件夹
        child_tex_file_output_path.parent.mkdir(parents=True, exist_ok=True)
        # 输出模板渲染后的结果
        print(f"写出子模板渲染结果至：{child_tex_file_output_path}")
        with open(child_tex_file_output_path, "w", encoding="utf-8") as fp:
            fp.write(template.render())
        # 记录已处理的子模板路径
        children.add(child_tex_path)

        return path

    # 注册过滤器
    latex_jinja_env.filters["real_relative_path"] = real_relative_path
    latex_jinja_env.filters["include_code"] = include_code
    latex_jinja_env.filters["input_tex"] = input_tex

    # 匹配所有在 template_search_path 路径下符合.root_template_file_suffix 后缀，.tex 后缀的 Tex 文件
    for root_template_tex_file_path in (Path(config.template_search_path)).glob(
        f"**/*{config.root_template_file_suffix}.tex"
    ):
        template = latex_jinja_env.get_template(
            str(root_template_tex_file_path.relative_to(config.template_search_path))
        )
        # 输出模板渲染后的结果
        output_root_tex_file_path = Path(config.output_dir_path) / re.sub(
            r"(.*?)" + config.root_template_file_suffix + "$",
            r"\1.tex",
            root_template_tex_file_path.stem,
        )
        # 自动建立可能缺失的文件夹
        output_root_tex_file_path.parent.mkdir(parents=True, exist_ok=True)
        print(f"写出根模板渲染结果至：{output_root_tex_file_path}")
        with open(output_root_tex_file_path, "w", encoding="utf-8",) as fp:
            fp.write(
                template.render(
                    author_info={
                        "author_name": {"trans": "姓名", "value": config.author_name},
                        "author_class_name": {
                            "trans": "班级",
                            "value": config.author_class_name,
                        },
                        "author_major_name": {
                            "trans": "专业",
                            "value": config.author_major_name,
                        },
                        "author_student_number": {
                            "trans": "学号",
                            "value": config.author_student_number,
                        },
                    }
                )
            )


if __name__ == "__main__":
    config = BuildConfig.load()
    main(config)
