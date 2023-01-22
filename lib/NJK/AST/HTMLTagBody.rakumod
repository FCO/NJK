use NJK::AST::HTML;

unit class NJK::AST::HTMLTagBody does NJK::AST::HTML;

has Str      $.tag-name is required;
has          %.params;
has NJK::AST @.body;
