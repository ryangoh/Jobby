require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, 'vertdeal.com'
set :deploy_to, '/home/ryan/project/Jobby'
set :repository, 'https://github.com/ryangoh/Jobby.git'
set :branch, 'master'
set :term_mode, nil
set :rails_env, 'production'
set :branch, 'master'
set :db_name, 'jobby_production2'

# For system-wide RVM install.
#   set :rvm_path, '/usr/local/rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log']

# Optional settings:
#   set :user, 'foobar'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.
set :user, 'ryan'
set :port, '22'
set :forward_agent, true

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-1.9.3-p125@default]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]

  queue! %[touch "#{deploy_to}/.rbenv-vars"]
  queue  %[echo "-----> Be sure to add your ENV VAR in '#{deploy_to}/.rbenv-vars'."]

  invoke :'setup:db:database_yml'
  # invoke :'create:database'
  # queue %[
  #   repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
  #   repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
  #   if [ -z "${repo_port}" ]; then repo_port=22; fi &&
  #   ssh-keyscan -p $repo_port -H $repo_host >> ~/.ssh/known_hosts
  # ]
end


desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_create'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    invoke :restartng

    to :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
    end
  end
end


desc "Populate shared database.yml"
task :'setup:db:database_yml' => :environment do
  database_yml = <<-DATABASE.dedent
    #{rails_env}:
      adapter: postgresql
      encoding: unicode
      database: #{db_name}
      username: <%= ENV['DATABASE_USER'] %>
      password: <%= ENV['DATABASE_PASS'] %>
      host: localhost
      timeout: 5000
      pool: 5
  DATABASE
  queue! %{
    echo "-----> Populating shared database.yml"
    echo "#{database_yml}" > #{deploy_to!}/shared/config/database.yml
    echo "-----> Done"
  }
end

#restart nginx server
task :restartng do
  queue "sudo nginx -s reload"
end

task :logs do
  queue 'sudo tail -f /var/log/nginx/error.log'
end

task :reboot do
  queue "sudo reboot"
end

task :prodlog do
  queue "tail -f #{deploy_to}/shared/log/production.log"
end
# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers
class String
  def dedent
    lines = split "\n"
    return self if lines.empty?
    indents = lines.map do |line|
      line =~ /\S/ ? (line.start_with?(" ") ? line.match(/^ +/).offset(0)[1] : 0) : nil
    end
    min_indent = indents.compact.min
    return self if min_indent.zero?
    lines.map { |line| line =~ /\S/ ? line.gsub(/^ {#{min_indent}}/, "") : line }.join "\n"
  end
end
