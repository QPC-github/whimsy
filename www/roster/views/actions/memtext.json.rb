# get entry for @userid
entry = ASF::Person.find(@userid).members_txt(true)
raise Exception.new("unable to find member entry for #{userid}") unless entry

# identify file to be updated
members_txt = ASF::SVN['private/foundation/members.txt']

# construct commit message
message = "Update entry for #{ASF::Person.find(@userid).member_name}"

# update members.txt
_svn.update members_txt, message: message do |dir, text|
  # replace entry
  text.sub! entry, " *) #{@entry.strip}\n\n"

  # save the updated text
  ASF::Member.text = text

  # return the updated (and normalized) text
  ASF::Member.text
end

# return updated committer info
_committer Committer.serialize(@userid, env)
