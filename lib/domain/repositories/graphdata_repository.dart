
import '../../infrastructure/models/graphdata_model.dart';
import '../../infrastructure/models/summary_model.dart';


abstract class GraphDataRepository {
   Future<GraphDataModel> fetchgraphdata();
}
