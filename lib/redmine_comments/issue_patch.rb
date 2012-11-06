module RedmineComments
  module IssuePatch
    def self.included(base)
      base.send :include, InstanceMethods
      base.class_eval do
        has_many :comments, :as => :commented, :dependent => :delete_all, :order => "created_on"
      end
    end

    module InstanceMethods
      def comment_recipients
        notified = []
        # Author and assignee are always notified unless they have been
        # locked or don't want to be notified
        notified << author if author
        if assigned_to
          notified += (assigned_to.is_a?(Group) ? assigned_to.users : [assigned_to])
        end
        if assigned_to_was
          notified += (assigned_to_was.is_a?(Group) ? assigned_to_was.users : [assigned_to_was])
        end

        notified += project.notified_users
        notified.uniq!

        # Remove users that can not view private comments
        notified.reject! {|user| !user.allowed_to?(:view_private_comments, self.project) }
        # Only keep active users who have notifications enabled for this project/issue
        notified = notified.select {|u| u.active? && u.notify_about?(self)}
        # Remove users that can not view the issue
        notified.reject! {|user| !visible?(user) }

        notified.map(&:mail)
      end
    end
  end
end
