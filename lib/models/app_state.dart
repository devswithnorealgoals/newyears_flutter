class AppState {
  // Your app will use this to know when to display loading spinners.
  bool authenticated;

  // Constructor
  AppState({this.authenticated = false});

  @override
  String toString() {
    return 'AppState{authenticated: $authenticated}';
  }
}
