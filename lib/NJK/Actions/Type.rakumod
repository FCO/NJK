use NJK::Type;

unit role NJK::Grammar::Type;

method type($/) {
  make NJK::Type.new: $/
}
