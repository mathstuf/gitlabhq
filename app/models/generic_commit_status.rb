# == Schema Information
#
# Table name: commit_status
#
#  id                :integer          not null, primary key
#  stage             :text
#  tags              :text
#  show_warning      :boolean
#  allow_failure     :boolean
#  cancel_url        :text
#  download_url      :text
#  retry_url         :text
#  information_url   :text
#  information_label :text
#

class GenericCommitStatus < CommitStatus
  # GitHub compatible API
  alias_attribute :context, :name

  acts_as_taggable

  def tag_list
    tags.split(',')
  end
end
