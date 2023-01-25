use NJK::AST::Extends;
use NJK::Grammar;
unit role NJK::Actions::Extends;

method statement:sym<extends>($/ is copy) {
  my $orig = $/;
  my $file = $<file>.made;
  my $match = NJK::Grammar.parse(:actions(self), $file.IO.slurp);
  die "Error parsing file $file" unless $match;
  $orig.make: NJK::AST::Extends.new:
    :file($file),
    :exported($match.ast),
}

method file($/) {
  make $<quoted-file>.made
}

method quoted-file:sym<double>($/) { make ~$<value> }
method quoted-file:sym<single>($/) { make ~$<value> }
