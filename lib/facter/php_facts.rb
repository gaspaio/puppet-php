# php_facts.rb


# Get the php extension_dir constant. 
# Some extensions (xdebug) are installed in this directory
Facter.add("php_extension_dir") do
  setcode do
    cmd = %x[php -i 2> /dev/null | grep "^extension_dir" | awk '{print $3}']
    cmd.gsub(/\r/,"").gsub(/\n/,"").strip
  end
end

Facter.add("php_pecl_exec") do
  setcode do
    cmd = %x[which pecl]
    cmd.gsub(/\r/,"").gsub(/\n/,"").strip
  end
end

Facter.add("php_pear_exec") do
  setcode do
    cmd = %x[which pear]
    cmd.gsub(/\r/,"").gsub(/\n/,"").strip
  end
end
