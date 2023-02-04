unit role NJK::Grammar::Variables;

rule statement:sym<input> {
  <njk-tag("input", /<declare-var>/)>
  {
    my $dcl = $<njk-tag><regex><declare-var>;
    require ::("NJK::Type");
    %*VARIABLES{$dcl<var-name>.Str.trim} = ::("NJK::Type").new: ($dcl<type>.defined ?? $dcl<type> !! "any").Str;
    %*INPUTS{$dcl<var-name>.Str.trim}    = ::("NJK::Type").new: ($dcl<type>.defined ?? $dcl<type> !! "any").Str;
  }
}

rule statement:sym<set> {
  :my $*LAST-TYPE;
  <njk-tag("set", /<declare-var> <.ws> "=" <.ws> <logic>/)>
  {
    my $dcl = $<njk-tag><regex><declare-var>;
    require ::("NJK::Type");
    %*VARIABLES{$dcl<var-name>.Str.trim} = do with $dcl<type> -> $type {
      ::("NJK::Type").new: $type
    } elsif $*LAST-TYPE {
      $*LAST-TYPE
    } else {
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

rule declare-var {
  <var-name> [ ":" <type> ]?
}

rule variable {
  :my @vars = |%*VARIABLES.keys, |(%*PARENT-VARIABLES // %()).keys;
  @vars || <var-name> && <error("Variable not defined")>
}
