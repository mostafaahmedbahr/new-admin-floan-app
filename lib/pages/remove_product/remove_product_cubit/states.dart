abstract class RemoveProductStates{}

class RemoveInitState extends RemoveProductStates{}

class RemoveProductLoadingState extends RemoveProductStates{}
class RemoveProductSuccessState extends RemoveProductStates{}
class RemoveProductErrorState extends RemoveProductStates{}

class GetAllProductsLoadingState extends RemoveProductStates{}
class GetAllProductsSuccessState extends RemoveProductStates{}
class GetAllProductsErrorState extends RemoveProductStates{}


class DeleteProductLoadingState extends RemoveProductStates{}
class DeleteProductSuccessState extends RemoveProductStates{}
class DeleteProductErrorState extends RemoveProductStates{}


class DeleteImagesLoadingFromStorage extends RemoveProductStates{}
class DeleteImagesSuccessFromStorage extends RemoveProductStates{}
class DeleteImagesErrorFromStorage extends RemoveProductStates{}

