// Import the Vulkan library for Dart
import 'package:vulkan/vulkan.dart';

// Create a Vulkan graphics instance
final instance = Vulkan.instance;

// Set up the application info
final appInfo = VkApplicationInfo(
  applicationName: 'MachineCopilot',
  applicationVersion: 1,
  engineName: 'Mapilot',
  engineVersion: 1,
  apiVersion: VkVersion(1, 0, 0),
);

// Set up the instance info
final instanceInfo = VkInstanceCreateInfo(
  applicationInfo: appInfo,
);

// Create the Vulkan instance
final VkInstance instance = await instance.createInstance(instanceInfo);
