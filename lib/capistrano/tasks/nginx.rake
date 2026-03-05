namespace :nginx do
  desc 'Upload Nginx configuration and reload Nginx'
  task :setup do
    on roles(:web) do
      upload! "config/nginx/production.conf", "/tmp/cdp_web_web_aws_deploy_task.conf"
      execute :sudo, :cp, "/tmp/cdp_web_web_aws_deploy_task.conf", "/etc/nginx/conf.d/cdp_web_web_aws_deploy_task.conf"
      execute :sudo, :nginx, "-t"
      execute :sudo, :systemctl, :reload, :nginx
    end
  end

  desc 'Reload Nginx'
  task :reload do
    on roles(:web) do
      execute :sudo, :systemctl, :reload, :nginx
    end
  end

  desc 'Restart Nginx'
  task :restart do
    on roles(:web) do
      execute :sudo, :systemctl, :restart, :nginx
    end
  end

  desc 'Check Nginx status'
  task :status do
    on roles(:web) do
      execute :sudo, :systemctl, :status, :nginx
    end
  end
end
