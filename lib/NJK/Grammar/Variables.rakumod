unit role NJK::Grammar::Variables;

rule statement:sym<input> {
  <njk-tag("input", /<declare-var>/)>
  {
    my $dcl = $<njk-tag><regex><declare-var>;
    require ::("NJK::Type");
    %*VARIABLES{$dcl<var-name>.Str.trim} = $dcl<type>.defined ?? $dcl<type>.made !! ::("NJK::Type").new: "any";
    %*INPUTS{$dcl<var-name>.Str.trim}    = $dcl<type>.defined ?? $dcl<type>.made !! ::("NJK::Type").new: "any";
  }
}

rule statement:sym<set> {
  :my $*LAST-TYPE;
  <njk-tag("set", /<declare-var(:no-value)> <.ws> "=" <.ws> <logic>/)>
  {
    my $dcl = $<njk-tag><regex><declare-var>;
    %*VARIABLES{$dcl<var-name>.Str.trim} = do with $dcl<type> -> $_ {
      .made
    } elsif $*LAST-TYPE {
      $*LAST-TYPE
    } else {
      require ::("NJK::Type");
      ::("NJK::Type").new: "any"
    }
  }
}

rule statement:sym<set-block> {
  <njk-block("set", /<declare-var>/, /<part>*/)>
}

token var-name {
  <[a..zA..Z_]><[a..zA..Z0..9_]>*
}

rule declare-var(Bool :$no-value) {
  <var-name> [ ":" <type> ]? [ '#"' ~ '"' $<doc>=[<-["]>*] ]? [ <?{ $no-value }> || [ "=" <default-value=.logic>]? ]
}

rule variable {
  :my @vars = |%*VARIABLES.keys, |(%*PARENT-VARIABLES // %()).keys;
  @vars || <var-name> && <error("Variable not defined")>
}
