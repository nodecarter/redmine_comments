module RedmineComments
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_issues_form_details_bottom,
              :partial => 'issue_comments/buttons_and_comments'
  end
end
