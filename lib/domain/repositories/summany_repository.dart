
import '../../infrastructure/models/summary_model.dart';


abstract class SummanyRepository {
   Future<SummaryModel> fetchsummany();
}
