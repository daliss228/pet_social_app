enum ViewState {Idle, Busy}

abstract class LoaderState {
  
  ViewState _viewState = ViewState.Idle;

  ViewState get viewState => this._viewState;

  set viewState(ViewState viewState);

}