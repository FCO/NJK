use NJK::AST::Logic;
use NJK::AST::Filter;
unit class NJK::AST::Value does NJK::AST::Logic;

has NJK::AST::Logic  $.value;
has NJK::AST::Filter @.filters;
