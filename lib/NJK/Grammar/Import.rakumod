unit role NJK::Grammar::Import;

rule statement:sym<import> {
  <njk-tag("import", / <file> /)>
  {
    require ::("NJK::Actions");
    my $file = $<njk-tag><regex><file>.made;
    my $unit = ::?CLASS.parsefile(:actions(::("NJK::Actions")), $file).ast;
    for $unit.block.variables.kv -> $k, $v {
      %*VARIABLES{$k} = $v
    }
  }

}
rule statement:sym<import-as> {
  <njk-tag("import", / <file> <.ws> "as" <.ws> <var-name>/)>
  {
    my $file = $<njk-tag><regex><file>.made;
    my $name = $<njk-tag><regex><var-name>;
    require ::("NJK::Actions");
    my $unit = ::?CLASS.parsefile(:actions(::("NJK::Actions")), $file).ast;
    require ::("NJK::Type");
    %*VARIABLES{ $name.made } = ::("NJK::Type").new: "object";
  }
}
rule statement:sym<from-import> {
  :my $unit;
  :my %vars;
  <njk-tag(
    "from",
    /
      <file> <.ws>
      "import" <.ws>
      {
        my $file = $<file>.made;
        require ::("NJK::Actions");
        {
          my $/;
          $unit = ::?CLASS.parsefile(:actions(::("NJK::Actions")), $file).ast;
        }
        %vars = $unit.block.variables.pairs;
      }
      <as-pair(%vars.keys)>+ %% ","
    /
  )>
  {
    my @pairs   = $<njk-tag><regex><as-pair>».made;
    for @pairs -> (Str :$from, Str :$to) {
      %*VARIABLES{$to} = %vars{$from}
    }
  }
}
rule as-pair(Set() $vars) {
  [ <from=.var-name> <?{ $vars{ ~$<from> } }> || <.error("Variable not found on file")> ]
  [ "as" <to=.var-name> ]?
  {
    make %(
      from => $<from>.Str.trim,
      to   => ($<to> // $<from>).Str.trim,
    )
  }
}
