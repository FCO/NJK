use NJK::AST;

unit class NJK::AST::DeclareVar does NJK::AST;

has Str $.name;
has     $.default-value;
has Str $.doc;
