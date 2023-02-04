use NJK::Type;

unit role NJK::Actions::Type;

method type($/) {
  make NJK::Type.new: $/
}
