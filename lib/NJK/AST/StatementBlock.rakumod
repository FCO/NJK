use NJK::AST;

unit class NJK::AST::StatementBlock does NJK::AST;

has NJK::AST @.parts;
has          %.variables;
has          %.blocks;
