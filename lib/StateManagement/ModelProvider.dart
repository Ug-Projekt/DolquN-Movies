/**
 * yeganaaa@163.com
 */

import 'package:flutter/widgets.dart';

abstract class Model {
  var notifier = ChangeNotifier();
  void applyChanges<T extends Model>([void callback(T model) = null]){
    (callback ??= (m){})(this);
    notifier.notifyListeners();
  }
}

class ModelProvider<T extends Model> extends StatefulWidget {
  final Widget child;
  final T model;

  const ModelProvider({Key key, @required this.model, @required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ModelProviderState<T>();
}

class _ModelProviderState<T extends Model> extends State<ModelProvider<T>> {
  @override void dispose() {
    widget.model.notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModelContainer<T>(
      child: widget.child,
      model: widget.model,
    );
  }
}

class ModelContainer<T extends Model> extends InheritedWidget {
  final Widget child;
  final T model;

  ModelContainer({Key key, @required this.child, @required this.model}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(ModelContainer oldWidget) => true;

  static ModelContainer<T> of<T extends Model>(BuildContext context) {
    var type = _ofType<ModelContainer<T>>();
    var inheritance = context.inheritFromWidgetOfExactType(type);
    assert(inheritance != null, "Can't find any subclass of $type");
    return inheritance;
  }

  static Type _ofType<T>() => T;
}


typedef Widget WidgetBuilderWithModel<T extends Model> (BuildContext context, Widget child, T data);

class ModelDescendant<T extends Model> extends StatefulWidget {
  final WidgetBuilderWithModel<T> onChanged;
  final T referenceModel;
  final Widget Function(BuildContext context, T data) child;

  Widget _childWidget;

  ModelDescendant({Key key, this.onChanged, this.referenceModel, this.child}) : assert(onChanged != null || child != null), super(key: key);
  @override
  State<StatefulWidget> createState(){

    return _ModelDescendantState<T>();
  }
}

class _ModelDescendantState<T extends Model> extends State<ModelDescendant<T>> {
  Model model;

  void _handleUpdate(){
      setState(() {});
  }

  @override dispose(){
    model.notifier.removeListener(_handleUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model ??= (){
      var model = widget.referenceModel ?? ModelContainer.of<T>(context).model;
      model.notifier.addListener(_handleUpdate);
      return model;
    }();
    var childBuilder = widget.child ?? (context, child) => null;
    widget._childWidget ??= childBuilder(context, model);
    var onChanged = widget.onChanged ?? (context, child, data) => child;
    var child = onChanged(context, widget._childWidget, model);
    return child;
  }
}

//
//class ModelDescendant2<T extends Model, E extends Model> extends StatelessWidget {
//  final Widget Function(BuildContext context, Widget child, T data1, E data2,) onChanged;
//  final T referenceModel1;
//  final E referenceModel2;
//  final Widget Function(BuildContext context, T data1, E data2) child;
//
//  const ModelDescendant2({Key key, this.onChanged, this.referenceModel1, this.referenceModel2, this.child}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return ModelDescendant<T>(
//      referenceModel: referenceModel1,
//      onChanged: (context, _, model1) => ModelDescendant<E>(
//        referenceModel: referenceModel2,
//        child: (context, data2) => child(context, model1, data2),
//        onChanged: (context, child, model2) => onChanged(context, child, model1, model2),
//      ),
//    );
//  }
//}
//
//class ModelDescendant3<T extends Model, E extends Model, F extends Model> extends StatelessWidget {
//  final Widget Function(BuildContext context, Widget child, T data1, E data2, F data3) onChanged;
//  final T referenceModel1;
//  final E referenceModel2;
//  final F referenceModel3;
//  final Widget Function(BuildContext context, T data1, E data2, F data3) child;
//
//  const ModelDescendant3({Key key, this.onChanged, this.referenceModel1, this.referenceModel2, this.child, this.referenceModel3}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return ModelDescendant<T>(
//      referenceModel: referenceModel1,
//      onChanged: (context, _, model1) => ModelDescendant2<E, F>(
//        referenceModel1: referenceModel2,
//        referenceModel2: referenceModel3,
//        child: (context, data2, data3) => child(context, model1, data2, data3),
//        onChanged: (context, child, model2, model3) => onChanged(context, child, model1, model2, model3),
//      ),
//    );
//  }
//}
