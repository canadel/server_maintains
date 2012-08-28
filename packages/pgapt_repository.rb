package :pgapt_repository do
  description 'PGapt packages repository'

  apt_list = '/etc/apt/sources.list'
  pgapt_repo = %q[
deb http://pgapt.debian.net/ squeeze-pgapt main
]
  push_text pgapt_repo, apt_list, :sudo => true do
    pre :install, 'wget -q http://pgapt.debian.net/ACCC4CF8.asc -O -| apt-key add -'
    pre :install, 'apt-get update'
  end

  verify do
    file_contains "/etc/apt/sources.list", "pgapt"
  end
end
