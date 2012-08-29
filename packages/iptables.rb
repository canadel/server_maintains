
package :iptables do
  description "Firewall"
  runner %{/etc/network/if-pre-up.d/iptables}
  requires :iptables_rules, :iptables_ifconfig
end

package :iptables_rules do
  description "Firewall rules"
  IPTABLES = File.join(::FIXTURES_DIR, "iptables")
  transfer IPTABLES, "/tmp" do
    post :install, %{mv /tmp/iptables /etc/iptables.up.rules}
  end
  verify do
    has_file "/etc/iptables.up.rules"
  end
end

package :iptables_ifconfig do
  description "Setup firewall with network"
  IPTABLES_IFUP = File.join(::FIXTURES_DIR, "iptables_ifup")
  transfer IPTABLES_IFUP, "/tmp" do
    post :install, %{mv /tmp/iptables_ifup /etc/network/if-pre-up.d/iptables}
    post :install, %{chmod +x /etc/network/if-pre-up.d/iptables}
  end
  verify do
    has_executable "/etc/network/if-pre-up.d/iptables"
  end
end
