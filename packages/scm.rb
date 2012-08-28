package :git, :provides => :scm do
  description 'Git Distributed Version Control'
  apt 'git-core'

  verify do
    has_file '/usr/bin/git'
  end
end

package :mercurial, :provides => :scm do
  description 'Mercurial Distributed Version Control'
  apt 'mercurial'

  verify do
    has_file '/usr/bin/hg'
  end
end

package :subversion, :provides => :scm do
  description 'Subversion Version Control'
  apt 'subversion'

  verify do
    has_file '/usr/bin/svn'
  end
end
