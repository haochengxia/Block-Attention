import os
from dotenv import load_dotenv

# 加载 .env 文件
load_dotenv()

# 读取环境变量
api_key = os.environ.get("AZURE_OPENAI_API_KEY")

print(api_key)  # 输出你的 API 密钥