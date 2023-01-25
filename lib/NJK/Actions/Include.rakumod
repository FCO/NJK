use NJK::AST::Include;
use NJK::Grammar;
unit role NJK::Actions::Include;

method statement:sym<include>($/ is copy) {
  my $orig = $/;
  my $file = $<file>.made;
  my $match = NJK::Grammar.parse(:actions(self), $file.IO.slurp);
  if $match {
    $orig.make: NJK::AST::Include.new:
      :file($file),
      :exported($match.ast),
  } elsif !$<no-error> {
    die "Error parsing file $file"
  }
}
