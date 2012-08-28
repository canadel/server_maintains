YURY_KEY = File.open(File.join(::KEYS_DIR, 'yury.id_rsa.pub'), 'r').read

package :deploy_user do
  requires  :add_deploy_user,
            :deploy_autorized_keys,
            :deploy_sudoers
            #, :deploy_id_rsa_pub
end

package :add_deploy_user do
  noop do
    pre :install, "groupadd #{::DEPLOY_USER}"
    pre :install, "useradd -s /bin/bash -m -g #{::DEPLOY_GROUP} #{::DEPLOY_USER}"
    pre :install, "mkdir -p /home/#{::DEPLOY_USER}/.ssh"
    pre :install, "touch /home/#{::DEPLOY_USER}/.ssh/id_rsa"
    pre :install, "touch /home/#{::DEPLOY_USER}/.ssh/id_rsa.pub"
    pre :install, "touch /home/#{::DEPLOY_USER}/.ssh/known_hosts"
    pre :install, "chown -R #{::DEPLOY_USER}:#{::DEPLOY_GROUP} /home/#{::DEPLOY_USER}/.ssh/"
    pre :install, "chmod 0600 /home/#{::DEPLOY_USER}/.ssh/*"
  end

  verify do
    has_file "/home/#{::DEPLOY_USER}/.ssh/id_rsa"
  end
end

package :allow_ssh_login do
  push_text "AllowUsers root #{::DEPLOY_USER}", "/etc/ssh/sshd_conf"

  verify do
    file_contains "/etc/ssh/sshd_conf", "AllowUsers root #{::DEPLOY_USER}"
  end
end

# generate keys to use with your "deploy" user(s), see ssh.rb for an example
package :deploy_autorized_keys do
  config_file = "/home/#{::DEPLOY_USER}/.ssh/authorized_keys"
  config_text = YURY_KEY.lstrip

  push_text config_text, config_file
  runner "chown -R #{::DEPLOY_USER}:#{::DEPLOY_GROUP} /home/#{::DEPLOY_USER}/.ssh/"

  verify do
    file_contains config_file, "ssh-rsa"
  end
end

package :deploy_id_rsa_pub do
  config_file = "/home/#{::DEPLOY_USER}/.ssh/id_rsa.pub"
  config_text = %q[
ssh-rsa [etc...]
].lstrip

  push_text config_text, config_file

  verify do
    file_contains config_file, "..."
  end
end

package :deploy_sudoers do
  config_file = '/etc/sudoers'
  config_text = %q[
deploy ALL=NOPASSWD: ALL
].lstrip

  push_text config_text, config_file

  verify do
    file_contains config_file, "#{::DEPLOY_USER} ALL=NOPASSWD: ALL"
  end
end
