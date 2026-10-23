# Use the official Tomcat 9 image with Java 11
FROM tomcat:9.0-jdk11-corretto

# Remove the default Tomcat welcome applications (optional)
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
    /usr/local/tomcat/webapps/docs \
    /usr/local/tomcat/webapps/examples \
    /usr/local/tomcat/webapps/host-manager \
    /usr/local/tomcat/webapps/manager

# Copy the war file into Tomcat's webapps folder
COPY attendance.war /usr/local/tomcat/webapps/attendance.war

# Copy the custom entrypoint script
COPY entrypoint.sh /usr/local/tomcat/bin/entrypoint.sh

# 修复 Windows 换行符问题，并赋予执行权限 (这行非常关键！)
RUN sed -i 's/\r$//' /usr/local/tomcat/bin/entrypoint.sh && \
    chmod +x /usr/local/tomcat/bin/entrypoint.sh

# Expose the default port (Render 会自动覆盖此端口)
EXPOSE 8080

# 使用自定义的启动脚本
CMD ["/usr/local/tomcat/bin/entrypoint.sh"]