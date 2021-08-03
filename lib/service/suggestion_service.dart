class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }

  List<Suggestion> suggestionDetails = [
    Suggestion('1', 'Data 1'),
    Suggestion('2', 'Data 2'),
    Suggestion('3', 'Data 3'),
    Suggestion('4', 'Data 4'),
    Suggestion('5', 'Data 5'),
  ];
}
