unit role NJK::Grammar::Variables;

rule statement:sym<input> {
  '{%' ~ '%}' [ "input" <declare-var(:input)> ]
}

rule statement:sym<set> {
  '{%' ~ '%}' [ "set" <declare-var> "=" <logic> ]
}

rule statement:sym<set-block> {
  '{%' ~ '%}' [ "set" <declare-var> ]
  <part>*
  '{%' ~ '%}' "endset"
}

rule declare-var(:$input) {
  <[a..zA..Z_]><[a..zA..Z0..9_]>*
  {
    %*VARIABLES{$/.Str.trim} = True;
    %*INPUTS{$/.Str.trim}     = True if $input;
  }
}

rule variable {
  :my @vars = |%*VARIABLES.keys, |(%*PARENT-VARIABLES // %()).keys;
  @vars || <[a..zA..Z_]><[a..zA..Z0..9_]>+ && <error("Variable not defined")>
}
