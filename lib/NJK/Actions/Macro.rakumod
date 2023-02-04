use NJK::AST::Macro;
use NJK::Type;

unit role NJK::Actions::Macro;

method statement:sym<macro>($/) {
  my %made   := $<njk-block>.made;
  my $inside  = %made<inside-tag><regex><macro-prototype>;
  make NJK::AST::Macro.new:
    :positional-params($inside<positional-params>».made».type),
    :block(%made<block><block>.made),
}
