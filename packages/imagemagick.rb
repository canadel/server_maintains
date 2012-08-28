
package :imagemagick do
  description 'ImageMagick image convertion library'

  apt %w( imagemagick libmagick9-dev )

  verify do
    has_file '/usr/bin/convert'
  end
end
