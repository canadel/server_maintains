# Sprinkle-based servers setup utilite

Initial commit of sprinkle-based servers install automation


How to install it:

    git clone https://github.com/canadel/server_maintains.git
    cd server_maintains
    bundle install
    
Then you need to add deploy user public key to:

    keys/deploy.id_rsa.pub
   
Next you need to create new server setup script, probably based on **ebike.rb**  

Add credintials, IP, passwords, desired DB name, DB user with password.

Then, probably you would to test how it will work, so just run in server_maintains directory:

    ./bundler_stubs/sprinkle -t -v -c -s your_script_name.rb

After that you can run script in production:

    ./bundler_stubs/sprinkle -v -c -s your_script_name.rb
    
… and see whats going on.

