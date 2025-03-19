import os
import re

def remove_comments_and_tests(content, ext):
    # 删除注释和测试模块的逻辑保持不变
    if ext == '.rs':
        content = re.sub(r'//.*', '', content)
        content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
        content = remove_rs_test_blocks(content)
    elif ext in ('.yaml', '.toml'):
        content = re.sub(r'^\s*#.*\n?', '', content, flags=re.MULTILINE)

    # 新增空行处理逻辑
    content = re.sub(r'\n\s*\n', '\n', content)  # 合并连续空行
    content = content.strip()                    # 去除首尾空行
    return content

def remove_rs_test_blocks(content):
    lines = content.split('\n')
    new_lines = []
    i = 0
    n = len(lines)
    while i < n:
        line = lines[i]
        stripped = line.strip()
        # 检查测试模块
        if stripped.startswith('#[cfg(test)]'):
            # 寻找后续的mod块
            j = i
            found_mod = False
            while j < n and (j - i) <= 2:  # 检查当前行及后两行
                if 'mod' in lines[j] and '{' in lines[j]:
                    found_mod = True
                    break
                j += 1
            if found_mod:
                # 计算大括号层级
                brace_level = lines[j].count('{') - lines[j].count('}')
                k = j + 1
                while k < n and brace_level > 0:
                    brace_level += lines[k].count('{')
                    brace_level -= lines[k].count('}')
                    k += 1
                i = k
                continue
        # 检查测试函数
        if stripped.startswith('#[test]'):
            # 寻找后续的fn定义
            j = i
            found_fn = False
            while j < n and (j - i) <= 2:
                if 'fn' in lines[j] and '{' in lines[j]:
                    found_fn = True
                    break
                j += 1
            if found_fn:
                # 计算大括号层级
                brace_level = lines[j].count('{') - lines[j].count('}')
                k = j + 1
                while k < n and brace_level > 0:
                    brace_level += lines[k].count('{')
                    brace_level -= lines[k].count('}')
                    k += 1
                i = k
                continue
        # 保留当前行
        new_lines.append(line)
        i += 1
    return '\n'.join(new_lines)

main_dir = os.getcwd()
output_file = os.path.join(main_dir, 'output.txt')

with open(output_file, 'w', encoding='utf-8') as out_f:
    for root, dirs, files in os.walk(main_dir):
        for file in files:
            if file.endswith(('.rs', '.yaml', '.toml')):
                file_path = os.path.join(root, file)
                rel_path = os.path.relpath(file_path, main_dir)
                with open(file_path, 'r', encoding='utf-8') as in_f:
                    content = in_f.read()
                ext = os.path.splitext(file)[1]
                processed_content = remove_comments_and_tests(content, ext)
                # 修改写入格式，使用单个换行分隔
                out_f.write(f'file_path: {rel_path}\n{processed_content}\n\n')