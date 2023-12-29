import sys

def mkBsaveFile(file_path, new_file_path, start_addr):
    # ファイルを読み込む
    with open(file_path, 'rb') as file:
        org_data = file.read()

    end_addr = start_addr + len(org_data) - 1

    # bsaveヘッダ
    bsave_header = bytes([0xfe, start_addr & 0xff, (start_addr >> 8) & 0xff, end_addr & 0xff, (end_addr >> 8) & 0xff, start_addr & 0xff, (start_addr >> 8) & 0xff])

    # 先頭にバイト列を追加
    new_data = bsave_header + org_data

    # ファイルを書き込みモードで開き、新しいデータを書き込む
    with open(new_file_path, 'wb') as file:
        file.write(new_data)

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python mkbsave.py <file_path> <new_file_path> <start_addr>")
        sys.exit(1)

    file_path = sys.argv[1]
    new_file_path = sys.argv[2]
    start_addr = int(sys.argv[3],16)

    # ファイルにスタートアドレスなどのbsaveのヘッダを追加する
    mkBsaveFile(file_path, new_file_path, start_addr)
