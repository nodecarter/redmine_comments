Deface::Override.new :virtual_path  => 'issues/_history',
                     :name          => 'add-comments-to-journals',
                     :insert_before => 'code[erb-silent]:contains("journal in journals")',
                     :text          => '<% if User.current.allowed_to?(:view_private_comments, @project); journals = (journals + @issue.comments).sort_by(&:created_on); journals.reverse! if User.current.wants_comments_in_reverse_order?; end %>'

Deface::Override.new :virtual_path  => 'issues/_history',
                     :name          => 'display-comments-with-journals',
                     :insert_after  => 'code[erb-silent]:contains("journal in journals")',
                     :text          => '<% if journal.is_a?(Comment) %><%= render :partial => "issue_comments/comment", :locals => { :comment => journal } %><% next; end %>'
