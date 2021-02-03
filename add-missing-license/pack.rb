require 'rake'
require 'zip'

download_packages = [
  "groonga-10.0.4-x64-vs2013-with-vcruntime.zip",
  "groonga-10.0.4-x64-vs2015-with-vcruntime.zip",
  "groonga-10.0.4-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.4-x64-vs2013.zip",
  "groonga-10.0.4-x64-vs2015.zip",
  "groonga-10.0.4-x64-vs2017.zip",
  "groonga-10.0.4-x64.zip",

  "groonga-10.0.4-x86-vs2013-with-vcruntime.zip",
  "groonga-10.0.4-x86-vs2015-with-vcruntime.zip",
  "groonga-10.0.4-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.4-x86-vs2013.zip",
  "groonga-10.0.4-x86-vs2015.zip",
  "groonga-10.0.4-x86-vs2017.zip",
  "groonga-10.0.4-x86.zip",

  "groonga-10.0.5-x64-vs2015-with-vcruntime.zip",
  "groonga-10.0.5-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.5-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.5-x64-vs2015.zip",
  "groonga-10.0.5-x64-vs2017.zip",
  "groonga-10.0.5-x64-vs2019.zip",
  "groonga-10.0.5-x64.zip",

  "groonga-10.0.5-x86-vs2015-with-vcruntime.zip",
  "groonga-10.0.5-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.5-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.5-x86-vs2015.zip",
  "groonga-10.0.5-x86-vs2017.zip",
  "groonga-10.0.5-x86-vs2019.zip",
  "groonga-10.0.5-x86.zip",

  "groonga-10.0.6-x64-vs2015-with-vcruntime.zip",
  "groonga-10.0.6-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.6-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.6-x64-vs2015.zip",
  "groonga-10.0.6-x64-vs2017.zip",
  "groonga-10.0.6-x64-vs2019.zip",
  "groonga-10.0.6-x64.zip",

  "groonga-10.0.6-x86-vs2015-with-vcruntime.zip",
  "groonga-10.0.6-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.6-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.6-x86-vs2015.zip",
  "groonga-10.0.6-x86-vs2017.zip",
  "groonga-10.0.6-x86-vs2019.zip",
  "groonga-10.0.6-x86.zip",

  "groonga-10.0.7-x64-vs2015-with-vcruntime.zip",
  "groonga-10.0.7-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.7-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.7-x64-vs2015.zip",
  "groonga-10.0.7-x64-vs2017.zip",
  "groonga-10.0.7-x64-vs2019.zip",
  "groonga-10.0.7-x64.zip",

  "groonga-10.0.7-x86-vs2015-with-vcruntime.zip",
  "groonga-10.0.7-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.7-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.7-x86-vs2015.zip",
  "groonga-10.0.7-x86-vs2017.zip",
  "groonga-10.0.7-x86-vs2019.zip",
  "groonga-10.0.7-x86.zip",

  "groonga-10.0.8-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.8-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.8-x64-vs2017.zip",
  "groonga-10.0.8-x64-vs2019.zip",
  "groonga-10.0.8-x64.zip",

  "groonga-10.0.8-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.8-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.8-x86-vs2017.zip",
  "groonga-10.0.8-x86-vs2019.zip",
  "groonga-10.0.8-x86.zip",

  "groonga-10.0.9-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.9-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.9-x64-vs2017.zip",
  "groonga-10.0.9-x64-vs2019.zip",
  "groonga-10.0.9-x64.zip",

  "groonga-10.0.9-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.9-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.9-x86-vs2017.zip",
  "groonga-10.0.9-x86-vs2019.zip",
  "groonga-10.0.9-x86.zip",

  "groonga-10.0.10-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.10-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.10-x64-vs2017.zip",
  "groonga-10.0.10-x64-vs2019.zip",
  "groonga-10.0.10-x64.zip",

  "groonga-10.0.10-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.10-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.10-x86-vs2017.zip",
  "groonga-10.0.10-x86-vs2019.zip",
  "groonga-10.0.10-x86.zip",

  "groonga-10.0.11-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.11-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.11-x64-vs2017.zip",
  "groonga-10.0.11-x64-vs2019.zip",
  "groonga-10.0.11-x64.zip",

  "groonga-10.0.11-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.11-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.11-x86-vs2017.zip",
  "groonga-10.0.11-x86-vs2019.zip",
  "groonga-10.0.11-x86.zip"
]

base_url = "http://packages.groonga.org/windows/groonga"

download_packages.each do |package|
  dirname = File.basename(package, ".zip")

  download_url = "#{base_url}/#{package}"
  sh("wget", download_url)
  sh("cp", package, "#{package}.org")
  unzip_success = true
  sh("unzip", "-q", package) do |success, rc|
    unzip_success = success
    unless success
      sh("rm", package, "#{package}.org")
      if Dir.exist?(dirname)
        sh("sudo", "rm", "-rf", dirname)
      elsif Dir.exist?(File.basename(dirname, "-with-vcruntime"))
        sh("sudo", "rm", "-rf", File.basename(dirname, "-with-vcruntime"))
      end
    end
  end
  next unless unzip_success
  sh("rm", package)

  if Dir.exist?(dirname)
    Dir.chdir(dirname)
  elsif Dir.exist?(File.basename(dirname, "-with-vcruntime"))
    Dir.chdir(File.basename(dirname, "-with-vcruntime"))
  end
  sh("sudo", "chmod", "755", "./share")
  sh("sudo", "chmod", "755", "./share/groonga/html")

end
