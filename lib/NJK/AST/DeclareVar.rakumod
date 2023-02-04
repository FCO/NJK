use NJK::AST;
use NJK::Type;

unit class NJK::AST::DeclareVar does NJK::AST;

has Str       $.name;
has NJK::Type $.type = NJK::Type.new: "any";
has NJK::AST  $.default-value;
has Str       $.doc;
