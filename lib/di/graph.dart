import 'package:dioc/dioc.dart';
import 'package:flutter_base_project/ui/routes/sample_router.dart';
import 'package:flutter_politburo/di/graph.dart';
import 'package:flutter_politburo/ui/component/debug_drawer.dart';
import 'package:flutter_politburo/ui/routes/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SampleGraph extends DefaultObjectGraph {
  SampleGraph() {
    ObjectGraph.graph = this;
  }

  static ObjectGraph get graph => ObjectGraph.graph;

  /// Registers common dependencies for dev and prod builds
  @override
  Future<Container> registerCommonDependencies(Container container) async {
    final prefs = await SharedPreferences.getInstance();
    container..register<SharedPreferences>((c) => prefs);
    return container;
  }

  /// registers development specific dependencies like a working debug drawer and HTTP clients setup to log
  @override
  Future<Container> registerDevDependencies(Container container) async {
    final routeMap = SampleRouter().routeMap();
    final router = SampleRouter().router;
    final packageInfoSection = PackageInfoDebugDrawerSection();
    final deviceInfoSection = DeviceInfoDebugDrawerSection();
    final mediaQuerySection = MediaQueryDebugDrawerSection();
    final routesSection = RouteEntrySection(routeMap, router);
    container.register<DebugDrawer>((c) => DebugDrawer([packageInfoSection, deviceInfoSection, mediaQuerySection, routesSection]));
    return container;
  }

  /// production ready dependencies pointing to the correct environment and without any debug code
  @override
  Future<Container> registerProdDependencies(Container container) async {
    return container;
  }

  /// mock dependencies for using the app with dummy data during development
  @override
  Future<Container> registerMockDependencies(Container container) async {
    return container;
  }

  /// test specific graph registration, doesn't pull from any other config
  @override
  Future<Container> registerTestDependencies(Container container) async {
    return container;
  }
}
