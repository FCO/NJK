use NJK::AST;
use NJK::AST::Unit;
unit class NJK::AST::Extends does NJK::AST;

has IO()           $.file;
has NJK::AST::Unit $.exported;
