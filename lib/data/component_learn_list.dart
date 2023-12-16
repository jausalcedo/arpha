import 'package:arpha/models/component_learn_model.dart';
import 'package:flutter/material.dart';

List<ComponentLearn> COMPONENT_LEARN_LIST = [
  ComponentLearn(
    title: "Motherboard",
    description: "A motherboard is the primary circuit board in a computer system that connects and facilitates communication between various hardware components. It serves as a central hub for crucial elements such as the CPU, memory, storage devices, and expansion cards.",
    operation: "The motherboard plays a vital role in coordinating the operation of different hardware components. It manages data transfer between the central processing unit (CPU), memory modules, storage devices, and peripherals. The motherboard uses buses and connectors to enable communication and data exchange, ensuring seamless interaction among the system's components.",
    components: "Key components of a motherboard include the CPU socket, memory slots, expansion slots, chipset, input/output ports, and power connectors. The CPU socket houses the processor, memory slots hold RAM modules, and expansion slots allow for additional components like graphics cards. The chipset manages data flow, and various ports provide connectivity for peripherals such as USB devices, networking, and audio.",
    history: "The evolution of motherboards has mirrored the progress in computing. In the 1970s, they emerged with microprocessors and personal computers. The 1990s saw a pivotal moment with the standardization of the ATX form factor, enhancing interoperability. The 2000s brought USB, expanded RAM, and integrated audio and networking. The 2010s focused on miniaturization, high-speed interfaces like PCIe, and technologies like M.2. In the 2020s, advancements continue with support for PCIe 4.0, USB 4.0, emphasizing power efficiency and enhanced connectivity.",
    color: Colors.blue[900]!,
    imagePath: "assets/images/learn/MOTHERBOARD.png"
  ),
  ComponentLearn(
    title: "Central Processing Unit (CPU)",
    description: "The term \"Central Processing Unit\" refers to the primary component of a computer responsible for executing instructions and performing calculations. It is often considered the brain of the computer and plays a crucial role in the operation of stored-program computers.",
    operation: "The CPU executes instructions from a computer's memory, performing tasks such as arithmetic and logic operations. It fetches, decodes, and executes instructions in a cycle known as the instruction cycle. The CPU interacts with other components like memory and input/output devices to carry out its functions.",
    components: "The CPU consists of several key components, including the control unit, arithmetic logic unit (ALU), registers, and cache. The control unit manages the execution of instructions, while the ALU performs mathematical and logical operations. Registers store data for quick access, and cache helps improve memory access speed.",
    history: "The \"central processing unit\" term has been in use since as early as 1955. Since the term \"CPU\" is generally defined as a device for software (computer program) execution, the earliest devices that could rightly be called CPUs came with the advent of the stored-program computer.",
    color: Colors.green,
    imagePath: "assets/images/learn/CPU.png"
  ),
  ComponentLearn(
    title: "Random Access Memory (RAM)",
    description: "RAM, or Random Access Memory, is a type of computer memory that provides quick access to data that is actively being used or processed by a computer. It is a volatile memory, meaning it loses its content when the power is turned off.",
    operation: "RAM serves as temporary storage for the operating system, applications, and data that are actively in use. When a computer is powered on, the operating system and software are loaded into RAM for quick access by the CPU. The data in RAM can be read and written rapidly, allowing for high-speed data access and manipulation during the computer's operation.",
    components: "RAM is typically made up of integrated circuits on memory modules that plug into the computer's motherboard. The key components include memory cells, which store binary data in the form of electrical charges, and a memory controller that manages data transfer between the RAM and the CPU. The most common types of RAM include DRAM (Dynamic RAM) and SRAM (Static RAM).",
    history: "From the 1940s to 1950s, early computers relied on mechanical or electrostatic storage for working memory, facing speed and reliability limitations. The 1960s-1970s introduced the first dynamic RAM (DRAM) with integrated circuits, providing faster and more compact memory. In the 1980s-1990s, DRAM continued to evolve with FPM and EDO, and SRAM was used for cache memory due to faster access times. The 2000s brought mainstream adoption of DDR Synchronous DRAM, improving data transfer rates through DDR2, DDR3, and DDR4. By the 2010s, DDR4 became standard, offering increased capacities and bandwidth. Ongoing 2020s developments include the adoption of DDR5 for higher data transfer rates and exploration of emerging memory technologies for future computing systems.",
    color: Colors.purple,
    imagePath: "assets/images/learn/RAM.png"
  ),
  ComponentLearn(
    title: "Storage",
    description: "Storage refers to the electronic data retention and retrieval system in computing, enabling the preservation and access of digital information over time. It encompasses various technologies and devices designed to store and manage data, including files, applications, and operating systems.",
    operation: "The operation of storage involves writing and reading data from storage devices. When data is stored, it is encoded onto the storage medium, and when retrieved, it is decoded and made accessible for use by the computer system. Storage devices, such as hard disk drives (HDDs), solid-state drives (SSDs), and optical drives, employ different mechanisms for data storage and retrieval.",
    components: "Key components of storage systems include the storage medium (e.g., magnetic disks, flash memory), the storage controller (managing data flow), and interfaces (connections allowing data exchange between storage and other system components). In the case of HDDs, platters, heads, and a spindle motor are integral components, while SSDs comprise memory cells, a controller, and an interface for data transfer.",
    history: "From the 1950s with magnetic tape and punched cards to the 1960s incorporating magnetic drums and disks, early computer storage evolved. The 1970s-1980s marked the introduction of hard disk drives (HDDs) and floppy disks as significant advancements. The 1990s saw optical storage's emergence with CD-ROMs, CD-RWs, and DVDs, alongside a surge in demand for larger-capacity HDDs due to increased PC adoption. The 2000s witnessed the shift from HDDs to Solid-State Drives (SSDs) for faster data access, while USB flash drives gained popularity for portability. In the 2010s, SSDs became widespread, and cloud storage services gained prominence. Ongoing 2020s trends include the evolution of SSD technology, the rise of NVMe for high-speed storage, and increased integration of cloud-based solutions in computing ecosystems.",
    color: Colors.orange,
    imagePath: "assets/images/learn/STORAGE.png"
  ),
  ComponentLearn(
    title: "Power Supply Unit (PSU)",
    description: "A Power Supply Unit (PSU) is a vital component in a computer system that converts electrical power from an outlet into a form suitable for the computer's internal components. It provides the necessary electrical energy to ensure proper functioning of the computer.",
    operation: "The PSU operates by taking electrical power from an external source, typically an electrical outlet, and transforming it into the required voltages needed by the computer's components. It supplies power to the motherboard, CPU, storage devices, graphics cards, and other peripherals, ensuring that each component receives the appropriate voltage and current.",
    components: "Key components of a PSU include the transformer, rectifier, capacitor, and voltage regulator. The transformer changes the input voltage, the rectifier converts alternating current (AC) to direct current (DC), capacitors smooth out voltage fluctuations, and the voltage regulator maintains stable voltage levels for the components.",
    history: "From the 1940s with vacuum tubes and transformers to the 1960s' transistors enabling compact power supplies, the 1980s-1990s introduced standardized form factors like AT and ATX for improved compatibility. In the 2000s, rising power demands led to more efficient PSU designs with modular cabling. The 2010s prioritized energy efficiency with the 80 PLUS certification, categorizing PSU efficiency levels. In the 2020s, the focus persists on energy efficiency, with advanced features like digital power management and smart technologies enhancing overall performance and control in power supply units (PSUs).",
    color: Colors.red,
    imagePath: "assets/images/learn/PSU.png"
  ),
  ComponentLearn(
    title: "Graphics Processing Unit (GPU)",
    description: "A GPU, or Graphics Processing Unit, is a specialized electronic circuit designed to accelerate the processing of images and videos. It is a crucial component in computers and other devices, focusing on rendering graphics for display.",
    operation: "The primary function of a GPU is to execute complex mathematical and geometric calculations required for rendering graphics. Unlike a CPU, which is more general-purpose, a GPU is optimized for parallel processing, making it well-suited for tasks such as rendering 3D graphics and processing large datasets in parallel.",
    components: "Key components of a GPU include the graphics core, video memory (VRAM), texture mapping units, and a rasterizer. The graphics core performs the bulk of the processing, VRAM stores graphical data, texture mapping units handle texture rendering, and the rasterizer converts digital images into pixels for display.",
    history: "In the 1980s, early GPUs were simple, mainly focused on 2D graphics until the introduction of dedicated video cards marked the start of GPU development. The 1990s saw GPUs evolving to handle complex 3D calculations, with companies like NVIDIA and ATI playing significant roles. The 2000s brought the term \"GPU\" to prominence, reflecting increased complexity. GPUs began general-purpose computing with CUDA and OpenCL. The 2010s witnessed a rapid performance increase driven by manufacturing advancements and specialized cores for tasks like AI. In the 2020s, GPUs advance with a focus on real-time ray tracing, increased parallel processing for scientific and AI applications, and integration into diverse devices like gaming consoles and autonomous vehicles.",
    color: const Color.fromARGB(255, 148, 116, 156),
    imagePath: "assets/images/learn/GPU.png"
  ),
  ComponentLearn(
    title: "Fan",
    description: "A PC fan, short for computer fan, is a mechanical device designed to cool the internal components of a computer system by dissipating heat generated during operation. It helps maintain optimal temperatures to prevent overheating and ensure the reliable functioning of electronic components.",
    operation: "PC fans operate by drawing air into the computer case and expelling hot air generated by the internal components. They are typically mounted on heatsinks or radiators, facilitating the efficient transfer of heat away from crucial elements such as the central processing unit (CPU) or graphics processing unit (GPU). The movement of air is driven by an electric motor within the fan, creating airflow that aids in cooling.",
    components: "Key components of a PC fan include the motor, blades, and the housing. The motor powers the rotation of the blades, which are strategically designed to maximize airflow. The housing encases the motor and blades, directing the airflow to specific areas within the computer case. Additionally, some advanced PC fans may include features like variable speed control for customized cooling.",
    history: "In the 1980s, early personal computers utilized basic cooling with passive heat sinks, later introducing basic fans for improved efficiency. By the 1990s, as computer components grew in power and complexity, fans became standard with standardized sizes and connectors. The 2000s saw advancements with variable speed fans, adjusting rotation based on temperature. In the 2010s, high-performance cooling solutions like liquid cooling and advanced fan designs emerged, along with aesthetic features like RGB lighting. In the 2020s, trends involve smart fan technologies for precise control and continued optimization of designs for both performance and energy efficiency.",
    color: const Color.fromARGB(255, 220, 92, 135),
    imagePath: "assets/images/learn/FAN.png"
  ),
];