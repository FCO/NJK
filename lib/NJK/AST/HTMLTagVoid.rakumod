use NJK::AST::HTML;

unit class NJK::AST::HTMLTagVoid does NJK::AST::HTML;

has Str $.tag-name is required;
has     %.params;
