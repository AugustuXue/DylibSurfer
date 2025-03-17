import os

# 获取当前执行目录
main_dir = os.getcwd()

# 指定输出文件路径
output_file = os.path.join(main_dir, 'output.txt')

# 以写入模式打开输出文件，使用utf-8编码
with open(output_file, 'w', encoding='utf-8') as out_f:
    # 递归遍历当前目录及其子目录
    for root, dirs, files in os.walk(main_dir):
        for file in files:
            # 检查文件是否以.rs、.yaml、.toml结尾
            if file.endswith('.rs') or file.endswith('.yaml') or file.endswith('.toml'):
                # 获取文件的完整路径
                file_path = os.path.join(root, file)
                # 计算相对于主目录的相对路径
                rel_path = os.path.relpath(file_path, main_dir)
                # 读取文件内容
                with open(file_path, 'r', encoding='utf-8') as in_f:
                    content = in_f.read()
                # 将提示词和相对路径以及文件内容写入输出文件
                out_f.write(f'file_path: {rel_path}\n\n')
                out_f.write(content)
                out_f.write('\n\n')
