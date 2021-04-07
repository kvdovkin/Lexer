# Copyright 2017-2020 The Verible Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""This module defines yacc/bison-related rules."""

def std_move_parser_symbols(name, src, out):
    """Convert symbol assignments (=) to std::move.

    Args:
      name: name of this label.
      src: a yacc/bison-generated .tab.cc source file.
      out: name of transformed source.
    """
    tool = "//common/parser:move_yacc_stack_symbols"
    native.genrule(
        name = name,
        srcs = [src],
        outs = [out],
        cmd = "$(location " + tool + ") < $< > $@",
        tools = [tool],
    )

def record_recovered_syntax_errors(name, src, out):
    """Save syntax error tokens prior to error recovery.

    Args:
      name: name of this label.
      src: a yacc/bison-generated .tab.cc source file.
      out: name of transformed source.
    """
    tool = "//common/parser:record_syntax_error"
    native.genrule(
        name = name,
        srcs = [src],
        outs = [out],
        cmd = "$(location " + tool + ") < $< > $@",
        tools = [tool],
    )

# TODO(fangism): implement a .output (human-readable state-machine) reader.
