#!/bin/bash
set -e

# Render 会注入 PORT 环境变量。Tomcat 默认监听 8080，如果 PORT 存在则替换。
if [ -n "$PORT" ] && [ "$PORT" != "8080" ]; then
    echo "Detected PORT: $PORT. Patching server.xml..."
    sed -i "s/port=\"8080\"/port=\"$PORT\"/g" /usr/local/tomcat/conf/server.xml
fi

echo "Starting Tomcat..."
exec /usr/local/tomcat/bin/catalina.sh run