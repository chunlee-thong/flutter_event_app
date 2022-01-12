double offsetToOpacity({
  required double currentOffset,
  required double maxOffset,
  double returnMax = 1,
}) {
  return (currentOffset * returnMax) / maxOffset;
}
