use NJK::AST;
use NJK::AST::StatementBlock;
use NJK::AST::Logic;
unit class NJK::AST::If does NJK::AST;

has NJK::AST::Logic          $.condition is required;
has NJK::AST::StatementBlock $.block     is required;
has Pair                     @.elif;
has NJK::AST::StatementBlock $.else;
