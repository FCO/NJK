unit role NJK::Grammar::Extends;

rule statement:sym<extends> {
  '{%' ~ '%}' [ "extends" [ <file> || <.error("Error on extends")> ] ]
}

token file {
  [
    <quoted-file> <?{ $<quoted-file><value>.Str.IO.e }> || <.error("File \o33[31m$<quoted-file><value>\o33[m does not exist")>
  ]
}

proto token quoted-file {*}
      token quoted-file:sym<double> { '"' ~ '"' $<value>=[<-["]>*] }
      token quoted-file:sym<single> { "'" ~ "'" $<value>=[<-[']>*] }
