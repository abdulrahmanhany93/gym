abstract class AppStates {}

class AppInitialStates extends AppStates {}

class AppCreateDataBase extends AppStates {}

class AppLoadingDataBase extends AppStates {}

class AppDataBaseLoaded extends AppStates {}

class AppDateBaseInserted extends AppStates {}

class AppDataBaseUpdated extends AppStates {}

class AppDataBaseMemberRemoved extends AppStates {}

class AppDataBaseEmployeeRemoved extends AppStates {}

class AppDataBaseMemberRenew extends AppStates {}

class AppPageViewChange extends AppStates {}

class AppSearchListClear extends AppStates {}

class AppSearchListUpdate extends AppStates {}
