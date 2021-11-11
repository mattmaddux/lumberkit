extension ListExtension<E> on List<E> {
  Iterable<T> mapWithIndex<T>(T toElement(int i, E e)) =>
      this.asMap().keys.map((i) => toElement(i, this[i]));
}
