require 'redmine'
require 'redmine_comments/hooks'

# Patches to existing classes/modules
require 'dispatcher'
Dispatcher.to_prepare do
  require_dependency 'issue'
  until Issue.included_modules.include?(RedmineComments::IssuePatch)
    Issue.send :include, RedmineComments::IssuePatch
  end
  require_dependency 'mailer'
  until Mailer.included_modules.include?(RedmineComments::MailerPatch)
    Mailer.send :include, RedmineComments::MailerPatch
  end
end

Redmine::Plugin.register :redmine_comments do
  name 'Redmine Comments plugin'
  description 'Private comments in issues for staff users'
  author 'Jean-Baptiste BARTH'
  author_url 'mailto:jeanbaptiste.barth@gmail.com'
  version '0.0.2'
  url 'https://github.com/jbbarth/redmine_comments'
  requires_redmine :version_or_higher => '1.4.4'
  project_module :issue_tracking do
    permission :view_private_comments, { }
    permission :manage_private_comments, { :issue_comments => [:new, :create] }
  end
end
